Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34717 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbbCJRce (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 10 Mar 2015 13:32:34 -0400
Received: by iecsl2 with SMTP id sl2so23292753iec.1
        for <util-linux@vger.kernel.org>; Tue, 10 Mar 2015 10:32:33 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 10 Mar 2015 18:32:33 +0100
Message-ID: <CAP-up9B=PYfQaYe6qi8bCYCkbPQJq3_3qoaHPxrki1_nF2J4_Q@mail.gmail.com>
Subject: logger --tag
From: Rainer Gerhards <rgerhards@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi all,

I have been working on some fixes to logger the past days (issues are
available on github). While I am almost done with that, I just noticed
a problem that seems to exist for rather long (at least it is present
in 2.20):

logger accepts spaces in the tag name, e.g.

logger -t "tag with spaces" test

This will lead to a tag "tag with spaces:" being written. Actually, in
2.20 this is a problem of syslog(3), which should not accept spaces.

Spaces are invalid inside a tag value (rfc 3164, rfc5424 and
traditional log socket format). The lead to misinterpretation. In the
case of rsyslog, the problem is not easily visible to the casual
observer, but can cause problems e.g. when writing logs to databases
or other tabular frontends.

When the new --rfc5424 option is used, a space inside the tag
invalidates the message (5424 is strict in contrary to 3164).

As the bug seems to be present for a long time, probably ever since, I
am unsure how to handle that. Options are (among others):

1) be to be strict by default, and emit an error message if a space is
contained inside a tag value. But that could potentially break
existing scripts.

2) be strict if and only if --rfc5424 is selected, but keep lazy in
all other cases

3) be strict if any rfc format is specified, but keep lazy in all other cases.

4) add a new option --strict (or whatever) and emit an error if it
either --rfc3164, --rfc5424 *or* --strict is given (--strict would
only affect system log socket format).

Options 2 to 4 would not break existing scripts, as these are new 2.26
options. I tend to option 4, which has the only downside that we still
permit invalid format to the local log socket.

What is the opinion here on this list?

Thanks,
Rainer
