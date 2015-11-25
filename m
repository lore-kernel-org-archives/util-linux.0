Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33572 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbbKYWLi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Nov 2015 17:11:38 -0500
Received: by pabfh17 with SMTP id fh17so71384603pab.0
        for <util-linux@vger.kernel.org>; Wed, 25 Nov 2015 14:11:38 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 26 Nov 2015 11:11:38 +1300
Message-ID: <CAJ5Duc7znhFzXK7yoWNTd6-PjjAKjahD1LUhW71p+g8zhatj-g@mail.gmail.com>
Subject: [Possible bug?] column command not ignoring escape sequences.
From: Michael Heyns <mike.bean.heyns@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Greetings,

I have a working script checking mimetypes i.e. `text/x-diff`;
`image/svg+xml` etc.

=================================
  1   #!/bin/bash
  2
  3   _Bold="\e[1m"
  4   _unBold="\e[22m"
  5   _Blue="\e[34m"
  6   _uC="\e[39m"
  7
  8   mimetype="$1"
  9   output="${_Bold}Testing MimeType${_unBold}:\t${mimetype}\n\t-------------"
 10
 11   get_default()
 12   {
 13       xdg-mime query default "$1"
 14   }
 15
 16   alias_of=`grep "^$mimetype " /usr/share/mime/aliases | cut -d' ' -f2`
 17   if [ -n "$alias_of" ]; then
 18       default=`get_default $alias_of`
 19       output="$output\nWhich is an alias of:\t$alias_of\t->
${default:-"none"}"
 20   else
 21       output="$output\nWhich is not an alias."
 22       alias_of=$mimetype
 23   fi
 24
 25   while : ; do
 26       subclass_of=`grep "^$alias_of " /usr/share/mime/subclasses |
cut -d' ' -f2`
 27       if [ -n "$subclass_of" ]; then
 28         default=`get_default $subclass_of`
 29         output="$output\nWhich is a subclass of:\t$subclass_of\t->
${default:-"none"}"
 30
 31         alias_of=$subclass_of
 32       else
 33         output="$output\nWhich is not a subclass"
 34         break
 35       fi
 36   done
 37
 38   echo -e $output | column -t -s $'\t'
=================================

Output without bold (line 8) is as expected but with bold, the column
is widened/broken.

I have removed the rest of the formatting in my example, but with
colors added it gets much worse.

I think I have narrowed it down to the `column` somehow including the
escape sequences in its spacing calculation? The same thing happens in
xterm, gnome-terminal and urxvt.

Is this expected behaviour? I'm learning a lot but sometimes I get a
headscratcher like this one.

Thank you for your time.

Sincerely,
Michael Heyns
