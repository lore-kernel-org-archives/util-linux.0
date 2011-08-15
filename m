Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:9844 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280Ab1HOOUA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Aug 2011 10:20:00 -0400
Date: Mon, 15 Aug 2011 16:19:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>, Sami Kerola <kerolasa@iki.fi>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: man-pages and usage() howto
Message-ID: <20110815141948.GH2038@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

Sami is already working on some howtos, what we need is some
consensus about a way how describe options.

My suggestion:

 * argument required:

   -o, --option FILE    # usage()
   -o, --option file    # man page

 * optional argument:

   -o, --option[=FILE]  # usage()
   -o, --option[=file]  # man page


 * synopsis

   - without individual options, bad example:
   
        command [-o offset] [--sizelimit size] [-p pfd] [-r] file

   - [options] is better:

        command [options] file

   - use more synopsis lines if the command supports more separated modes.

       command --add file
       command --del file

     (use common sense! ... if there is too many modes, then use [options])

     The options specific to the mode are allowed in the synopsis or
     in the man page should be per-mode section with description about
     the options.


 * common options:

   -V, --version
   -h, --help

 * suggestions:

   -a, --all
   -o, --output <list>
   -r, --raw
   -f, --force
   -b, --bytes   (don't print SIZE in human readable format)


 * We also need any consensus about groff formatting, the ideal
   solution would be add any Documentation/example.man

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
