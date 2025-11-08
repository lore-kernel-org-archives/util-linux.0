Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EF1F9D9
	for <util-linux@vger.kernel.org>; Sat,  8 Nov 2025 22:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762641695; cv=none; b=qnR0Trb/SbzV+Ox3jvYBvMGjhsfhEO2eFs4fpObt6rrocEkJA4iJrjf0FjQuww37jdUPRKYxzKeSzIUMhQrcgVgTqPKfGPf/NSiZ8AODpjAM7LY6vJFtLN19O/nbg5g83zEo68kEFSZxP4uPN8Aj2oZecQ/d+tZ3pE6eX6xYN+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762641695; c=relaxed/simple;
	bh=tgeiVticdngZjEv0h7LDsDZxDRObzGpA9HTY+rTrmLA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GvJ3OELJUC5WQOgaej0EQ4E6y7JEwQ/EZbjmWN1+Px1sm1hWoixqjQaNQ+yiTbZ3WelPBq00onvFkZea7MilZbmXLXvRisN9GBP8WdBWWGVsAhIOgsPFdMkJtKxqzy92yPBYO4BoED+nDf+A6WXQMJgNlXPW0OojoX7w+B6Dcwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=OiEvejIr; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="OiEvejIr"
Received: from localhost ([47.65.177.146])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.1/8.17.1.9) with ESMTPSA id 5A8MfLQj007937
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <util-linux@vger.kernel.org>; Sat, 8 Nov 2025 23:41:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1762641681; bh=tgeiVticdngZjEv0h7LDsDZxDRObzGpA9HTY+rTrmLA=;
	h=From:To:Subject:Date;
	b=OiEvejIrzs5jekaYM8Gay8UwdNyeL0w5GZ22XDb4cAWbRmThz0xvLBjT8aMpyiOy2
	 4Wch9NXqaU34ymyqPEmtRYR5YPneRM3+nw4g0nWW7Sn2tYp5PZvDo1DXcQCZq3dRcg
	 KU535fqQ50pSi9f5alxT3hqEsSmv59kIi3VXW+e4=
From: Dirk Gouders <dirk@gouders.net>
To: util-linux@vger.kernel.org
Subject: Experimental pager: lsp
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sat, 08 Nov 2025 23:41:20 +0100
Message-ID: <ghfrao87vz.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hello,

some time ago (in May), I talked to Karel and he told me it would be OK
for him if I write in util-linux about a terminal pager I am working on.
Hopefully some of the experts here will find it interesting
enough and the time to play with it and give some feedback.

The pager's name is lsp - list pages (or least significant pager).
Perhaps somewhat unlucky, because of "Language Server Protocol", but
when I started it and searched the web I didn't realize any name
collisions.

Anyway, you will certainly ask "Who needs just another pager?".
I implemented some features I was always missing in other pagers:

- On window resizes, reload manual pages to fit the new window size.
- Manual pages refer to others: allow to navigate to them.
  (And offer such links only if those manual pages exist on the running
   system, i.e. validate those references.)
- Allow to open other manual pages and to switch among all opened files.

Besides these "musts", I implemented a 3-level TOC mode that allows for
faster (or a different way of) navigation in large manual pages.

Further, an apropos buffer can be created to have all manual pages
available and be able to visit them.

Another nuance is the positioning of search matches: when I walk through
git logs, I often want to move commit-wise and ideally have the
commits starting in the first line.  In lsp I search for "^commit",
press ^l twice and from then on 'n' navigates to the next commit,
positioning it to the first line.

A latest feature that I implemented is the possibility to restart the
parent process (currently only git).  I find this useful when I do
`git diff` before adding changes and realize whitespace changes or other
small nits.  I then keep the diff-session, correct those nits in my
editor and in the diff-session just press 'r' to see those changes.

Finally, the negative part: lsp currently has no raw mode, i.e. it uses
ncurses and does all interpretation of SGR and backspace sequences.
Raw mode is the next thing I want to realize.


In case you are interested, lsp can be found at:

https://github.com/dgouders/lsp

Please use the next branch that has some recent fixes.

If you use Gentoo, lsp can be found in the GURU repo.

But manual installation isn't that hard, because ncurses is lsp's single
dependency, besides meson for installation.

Thank you and pardon in case you feel disturbed by this,

Dirk
