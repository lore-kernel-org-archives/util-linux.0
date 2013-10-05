Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ve0-f178.google.com ([209.85.128.178]:43155 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481Ab3JEU7z (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Sat, 5 Oct 2013 16:59:55 -0400
Received: by mail-ve0-f178.google.com with SMTP id jw12so3230547veb.9
        for <util-linux-ng@vger.kernel.org>; Sat, 05 Oct 2013 13:59:54 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 5 Oct 2013 23:59:54 +0300
Message-ID: <CAO2cUkTj+f+6xrgr6+WzY9D+TwwZHWYhMfuMKKYF=39vJ8wU6w@mail.gmail.com>
Subject: [RFC/PATCH] week numbers for cal
From: Tommi Kyntola <tommi.kyntola@gmail.com>
To: util-linux-ng@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I keep trying -w with cal from time to time and I finally decided it's
about time to do something about it. I'm not sure if this is something
you'd be interested in incorporating into util-linux cal, but it's
something I wanted, so here it is. There's gcal of course, but I only
wanted a toothpick not the whole forest.

I added -w|--week for showing week numbers. It defaults to North
American numbering, because cal itself defaults to Sundays being the
first day of the week. With Monday first it uses the ISO-8601 week
numbers.

I didn't worry too much about the implementation being as clean as
possible just yet, but should this be deemed worth a jack, I or anyone
else can take it to any direction.

The three relevant patches are in my github:
https://github.com/Kynde/util-linux.git
https://github.com/Kynde/util-linux/commits

Tommi Kyntola (4):
      cal: added two missing tests
      cal: added -w|--week for showing week numbers
      cal: tests for week number modes added
      cal: added more week number tests to cover various special cases

The first that's on top of Karel's tree is a minor test fix for
bigyear and sep1752 which seemed to lack final their last tests.

 misc-utils/cal.c            |  140 +++-
 tests/expected/cal/1mw      |   37 ++
 tests/expected/cal/3mw      |   37 ++
 tests/expected/cal/bigyear  |   51 ++
 tests/expected/cal/bigyearw |  257 ++++++++
 tests/expected/cal/colorw   |   55 ++
 tests/expected/cal/sep1752  |   51 ++
 tests/expected/cal/sep1752w |  249 ++++++++
 tests/expected/cal/weeknum  | 1485 +++++++++++++++++++++++++++++++++++++++++++
 tests/expected/cal/yearw    |  177 ++++++
 tests/ts/cal/1mw            |   59 ++
 tests/ts/cal/3mw            |   58 ++
 tests/ts/cal/bigyear        |    1 +
 tests/ts/cal/bigyearw       |   96 +++
 tests/ts/cal/colorw         |   71 +++
 tests/ts/cal/sep1752        |    1 +
 tests/ts/cal/sep1752w       |   96 +++
 tests/ts/cal/weeknum        |   87 +++
 tests/ts/cal/yearw          |   58 ++
 19 files changed, 3037 insertions(+), 29 deletions(-)


Please cc me as I'm not on the list.

cheers,
Tommi Kyntola
