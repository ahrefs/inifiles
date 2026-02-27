let fn = "specification.ini"

let () =
  (* no spec, should just parse correctly *)
  let spec = [] in
  match new Inifiles.inifile ~spec fn with
  | _ ->
    (* require a section that is missing *)
    let required = {Inifiles.sec_name = "required"; sec_required = true; sec_attributes = [] } in
    let spec = [required] in
    match new Inifiles.inifile ~spec fn with
    | _ ->
      Printf.eprintf "Parsed correctly despite missing required section\n";
      exit 1
    | exception Inifiles.Missing_section "required" ->
      (* require a section that exists and an optional section that is missing *)
      let sec_name = "three" in
      let three = {Inifiles.sec_name; sec_required = true; sec_attributes = [] } in
      let optional = {Inifiles.sec_name = "optional"; sec_required = false; sec_attributes = [] } in
      let spec = [optional; three] in
      match new Inifiles.inifile ~spec fn with
      | _ ->
        (* require "qux" attribute to exist *)
        let atr_name = "qux" in
        let required_attr = {Inifiles.atr_name; atr_required = true; atr_default = None; atr_validator = None} in
        let three = {Inifiles.sec_name; sec_required = true; sec_attributes = [required_attr] } in
        let spec = [three] in
        match new Inifiles.inifile ~spec fn with
        | _ ->
          Printf.eprintf "Parsed despite qux required but missing in input\n";
          exit 1
        | exception Inifiles.Missing_element "qux" ->
          (* missing qux should parse and contain default value *)
          let required_attr = {Inifiles.atr_name; atr_required = false; atr_default = Some ["quux"; "corge"]; atr_validator = None} in
          let three = {Inifiles.sec_name; sec_required = true; sec_attributes = [required_attr] } in
          let spec = [three] in
          match new Inifiles.inifile ~spec fn with
          | ini ->
            match ini#getaval sec_name atr_name with
            | ["corge"; "quux"] -> (
              (* require value to be 3 characters - this works *)
              let validator = Pcre2.regexp {|\w\w\w|} in
              let required_attr = {Inifiles.atr_name = "foo"; atr_required = true; atr_default = None; atr_validator = Some validator} in
              let three = {Inifiles.sec_name; sec_required = true; sec_attributes = [required_attr] } in
              let spec = [three] in
              match new Inifiles.inifile ~spec fn with
              | _ ->
                (* require argument to be 4 characters, this should fail to validate *)
                let validator = Pcre2.regexp {|\w\w\w\w|} in
                let required_attr = {Inifiles.atr_name = "foo"; atr_required = true; atr_default = None; atr_validator = Some validator} in
                let three = {Inifiles.sec_name; sec_required = true; sec_attributes = [required_attr] } in
                let spec = [three] in
                match new Inifiles.inifile ~spec fn with
                | _ ->
                  Printf.eprintf "Attribute validation succeeded despite key not matching validation\n";
                  exit 1
                | exception Inifiles.Invalid_element "foo: validation failed" ->
                  ()
            )
            | _ ->
              Printf.eprintf "Specification default failed, returned wrong value\n";
              exit 1
