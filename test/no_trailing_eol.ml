let () =
  (* make sure this file has no traling \n *)
  match new Inifiles.inifile "no_trailing_eol.ini" with
  | ini ->
    (* parsing should succeed *)
    match ini#getval "section" "eol" with
    | "notafterthis" -> ()
    | otherwise ->
      Printf.eprintf "Read incorrect value %S\n" otherwise;
      exit 1
