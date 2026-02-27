let () =
  match new Inifiles.inifile "broken_section.ini" with
  | _ ->
    (* parsing should not succeed, fail *)
    exit 1
  | exception Inifiles.Ini_parse_error (1, "broken_section.ini") ->
    (* we expect it to fail here *)
    ()
  | exception Inifiles.Ini_parse_error (lnum, file) ->
    Printf.eprintf "Unexpected failure at file %S, line number %d.\n" file lnum;
    exit 1
