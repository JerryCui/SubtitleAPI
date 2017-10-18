// This file is part of Subtitle API, the subtitle file read/write library of Subtitle Workshop
// URL: subworkshop.sf.net
// Licesne: GPL v3
// Copyright: See Subtitle API's copyright information
// File Description: SonicDVD Creator subtitle format saving functionality

function SubtitlesToFile_SONICDVD(Subtitles: TSubtitles; const FileName: String; const FPS: Single; From: Integer = -1; UpTo: Integer = -1): Boolean;
var
  tmpSubFile : TSubtitleFile;
  Indice     : String;
  i          : Integer;
begin
  Result := True;
  tmpSubFile := TSubtitleFile.Create;
  try

    for i := From to UpTo do
    begin
      Subtitles.Text[i] := RemoveSWTags(Subtitles.Text[i], True, True, True);
      Indice := IntToStr(i+1);
      while Length(Indice) < 4 do
        Insert('0', Indice, 0);
      tmpSubFile.Add(Indice + '  ' + MSToHHMMSSFFTime(Subtitles[i].InitialTime, FPS) + '  ' + MSToHHMMSSFFTime(Subtitles[i].FinalTime, FPS) + '  ' + Subtitles[i].Text, False);
      tmpSubFile.Add('', False);
    end;

    try
       if UTF8File
	  then begin           
           for I := 0 to TmpSubFile.Count - 1 do Tstr.add(TmpSubFile[I]);
		   try
             Tstr.SaveToFile(FileName, TEncoding.UTF8);
			except
			 Result := False;
            end;			           
         end
      else tmpSubFile.SaveToFile(FileName);
    except
      Result := False;
    end;
  finally
    tmpSubFile.Free;
  end;
end;
