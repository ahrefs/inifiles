let () =
  let ini = new Inifiles.inifile "correct_parse.ini" in
  let v = ini#getval "section" "key" in
  let expected = "value" in
  match String.equal v expected with
  | false ->
    Printf.eprintf "Expected %S but got %S\n" expected v;
    exit 1
  | true ->
    match ini#getaval "section" "key" with
    | ["value"; "duplicate"] -> (
      let v = ini#getval "section" "k" in
      let expected = "v" in
      match String.equal v expected with
      | false -> 
        Printf.eprintf "Expected %S but got %S\n" expected v;
        exit 1
      | true ->
        match ini#getval "section" "missing-key" with
        | _ -> 
          Printf.eprintf "Incorrectly retrieved missing key\n";
          exit 1
        | exception Inifiles.Invalid_element "missing-key" ->
          match ini#getval "missing-section" "missing-key" with
          | _ ->
            Printf.eprintf "Incorrectly retrieved missing section\n";
            exit 1
          | exception Inifiles.Invalid_section "missing-section" ->
            ini#delval "section" "key";
            let v = ini#getval "section" "key" in
            let expected = "duplicate" in
            match String.equal v expected with
            | false ->
              Printf.eprintf "Incorrect key revealed by delval\n";
              exit 1
            | true ->
              ())
    | _ ->
      Printf.eprintf "Unexpected getaval result\n";
      exit 1
