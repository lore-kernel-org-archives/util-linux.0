Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:33310 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752210AbcFBP5s (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 2 Jun 2016 11:57:48 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 60C4AAAB6
	for <util-linux@vger.kernel.org>; Thu,  2 Jun 2016 15:57:46 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: inconsistent behavior of --with-ncurses
Message-ID: <2da519ca-946c-1710-cdd8-15f212589bc0@suse.cz>
Date: Thu, 2 Jun 2016 17:57:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

One would expect, that --with-ncurses means: Use ncurses(w), and if it
is not available, force to fail. But ./configure --help tells something
different:

--with-ncurses     build with non-wide ncurses, default is wide version
                    (--without-ncurses disables all ncurses(w) support)

It implies, that --without-ncurses should force-disable non-wide ncurses.


In fact, none of that is true. The check now works in a strange way:

--without-ncurses means:

   Disable any variant of ncurses.

--with-ncurses means:

   - If ncurses is detected by pkgconfig files, --with-ncurses is a NOP.

   - If pkgconfig files are not present, it falls back to the described
     meaning: Force non-wide variant of the library.


Additionally, --with-ncurses does not disable widechar support, which
has unexpected results (see my mail [PATCH] Don't allow widechar with
plain ncurses)


What would be the better fix?

- Change description of --with-ncurses, and change behavior of library
   check. If ncursesw is not found, disable widechar support. Optionally
   add --disable-widechar to replace original meaning of --with-ncurses.

- Keep description as it is, and fix the main AS_IF and pkgconfig check
   to follow the description. --with-ncurses will disable widechar
   support. Optionally add --with-ncursesw.
-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
