// This file is part of Subtitle API, the subtitle file read/write library of Subtitle Workshop
// URL: subworkshop.sf.net
// Licesne: GPL v3
// Copyright: See Subtitle API's copyright information
// File Description: AQTitle subtitle format saving functionality

function SubtitlesToFile_AQTITLE(Subtitles: TSubtitles; const FileName: String; const FPS: Single; From: Integer = -1; UpTo: Integer = -1) : Boolean;
var
  tmpSubFile : TSubtitleFile;
  i          : Integer;
  Text       : String;
begin
  Result := True;
  tmpSubFile := TSubtitleFile.Create;
  try
    for i := From to UpTo do
    begin
      tmpSubFile.Add('-->> ' + PadLeft(IntToStr(TimeToFrames(Subtitles[i].InitialTime, FPS)),'0', 6), False);

      if StringCount(#13#10, Subtitles[i].Text) = 0 then
        Text := Subtitles[i].Text + #13#10
      else if StringCount(#13#10, Subtitles[i].Text) = 1 then
        Text := Subtitles[i].Text
      else if StringCount(#13#10, Subtitles[i].Text) > 1 then
        Text := Copy(Subtitles[i].Text, 0, Pos(#13#10, Subtitles[i].Text) + 2) + ReplaceEnters(Copy(Subtitles[i].Text, Pos(#13#10, Subtitles[i].Text) + 2, Length(Subtitles[i].Text)), ' ');

      Text := RemoveSWTags(Text, True, True, True, True); //added by adenry 2013.04.11

      tmpSubFile.Add(Text, False);
      tmpSubFile.Add('-->> ' + PadLeft(IntToStr(TimeToFrames(Subtitles[i].FinalTime, FPS)),'0', 6), False);
      tmpSubFile.Add('', False);
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
