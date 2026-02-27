let () =
  match new Inifiles.inifile "newline_sections.single.ini" with
  | ini ->
    (* parsing should succeed *)
    match ini#getval "section" "singlenewline" with
    | "in-between" -> ()
    | otherwise ->
      Printf.eprintf "Read incorrect value %S\n" otherwise;
      exit 1

let () =
  match new Inifiles.inifile "newline_sections.multiple.ini" with
  | ini ->
    (* parsing should succeed *)
    match ini#getval "section" "multiplenewlines" with
    | "in-between" -> ()
    | otherwise ->
      Printf.eprintf "Read incorrect value %S\n" otherwise;
      exit 1
