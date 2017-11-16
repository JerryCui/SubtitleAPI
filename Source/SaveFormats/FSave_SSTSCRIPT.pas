// This file is part of Subtitle API, the subtitle file read/write library of Subtitle Workshop
// URL: subworkshop.sf.net
// Licesne: GPL v3
// Copyright: See Subtitle API's copyright information
// File Description: Stream SubText Script subtitle format saving functionality

function SubtitlesToFile_SSTSCRIPT(Subtitles: TSubtitles; const FileName: String; From: Integer = -1; UpTo: Integer = -1): Boolean;
var
  tmpSubFile : TSubtitleFile;
  i          : Integer;
begin
  Result := True;
  tmpSubFile := TSubtitleFile.Create;
  try

    tmpSubFile.Add('SST 2.0.73', False);
    tmpSubFile.Add('[TITLES]', False);
    tmpSubFile.Add('fps=25.00', False);

    for i := From to UpTo do
    begin
      Subtitles.Text[i] := RemoveSWTags(Subtitles.Text[i], True, True, True);
      tmpSubFile.Add(IntToStr(i+1) + #9 + 'Default' + #9 + TimeToString(Subtitles[i].InitialTime, 'hh:mm:ss.zz') + #9 + TimeToString(Subtitles[i].FinalTime, 'hh:mm:ss.zz') + #9 + ReplaceEnters(Subtitles[i].Text,'~') + #9 + 'SubRip', False);
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
