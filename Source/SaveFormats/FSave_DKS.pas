// This file is part of Subtitle API, the subtitle file read/write library of Subtitle Workshop
// URL: subworkshop.sf.net
// Licesne: GPL v3
// Copyright: See Subtitle API's copyright information
// File Description: DKS Subtitle Format subtitle format saving functionality

function SubtitlesToFile_DKS(Subtitles: TSubtitles; const FileName: String; From: Integer = -1; UpTo: Integer = -1): Boolean;
var
  tmpSubFile : TSubtitleFile;
  i          : Integer;
begin
  Result := True;
  tmpSubFile := TSubtitleFile.Create;
  try
    for i := From to UpTo do
    begin
      Subtitles.Text[i] := RemoveSWTags(Subtitles.Text[i], True, True, True);
      if (Subtitles[i].InitialTime = Subtitles[i].FinalTime) then
        Subtitles.FinalTime[i] := Subtitles[i].InitialTime + 1000;
      tmpSubFile.Add('[' + TimeToString(Subtitles[i].InitialTime, 'hh:mm:ss') + ']' + ReplaceEnters(Subtitles[i].Text,'[br]'), False);
      tmpSubFile.Add('[' + TimeToString(Subtitles[i].FinalTime, 'hh:mm:ss') + ']', False);
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
