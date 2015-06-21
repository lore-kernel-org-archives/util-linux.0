Return-Path: util-linux-owner@vger.kernel.org
Received: from antila.uberspace.de ([95.143.172.202]:53886 "EHLO
	antila.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbbFUOk7 convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 21 Jun 2015 10:40:59 -0400
Received: by wicgi11 with SMTP id gi11so54175807wic.0
        for <util-linux@vger.kernel.org>; Sun, 21 Jun 2015 07:34:16 -0700 (PDT)
MIME-Version: 1.0
From: Felix Neumann <felix.neumann@inka.de>
Date: Sun, 21 Jun 2015 16:33:57 +0200
Message-ID: <CA+w_OVdqj9ZgM8cRL3t2EFsYTJ-ZzYJb2eJZw-pP0oBM+HNEJg@mail.gmail.com>
Subject: Wording problem in man cal
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

in the man page for cal there's a small wording problem in section "bugs":

       cal program uses the 3rd of September 1752 as the date of the
       Gregorian calendar reformation -- that is when it happened in Great
       Britain and its colonies (including what is now the USA).  Ten days
       following that date were eliminated by this reformation, so the
       calendar for that month is rather unusual.  The actual historical
       dates at which the calendar reform happened in all the different
       countries (locales) are ignored.

If you type cal 9 1752, you get this output:

   September 1752
Mo Tu We Th Fr Sa Su
    1  2 14 15 16 17
18 19 20 21 22 23 24
25 26 27 28 29 30

Between Sept 2 and Sept 14, eleven dates are jumped; so the man page
should read something like "eleven days following Sept 2 were
eliminated"; in my opinion the current wording suggests there is a
date "September 3rd 1752", which is contradicted by cal's output..

I checked the man page on
http://man7.org/linux/man-pages/man1/cal.1.html as well as my CentOS 6
installation.

Best regards

Felix

-- 
Bornheimer Straße 120 / 53119 Bonn//
(01522) 869 27 41//
http://fxneumann.de / GPG-Schlüssel: 0x9CA91B2A
--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
