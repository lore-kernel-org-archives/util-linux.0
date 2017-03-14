Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750796AbdCNRwZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 14 Mar 2017 13:52:25 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C74BC04B94A
        for <util-linux@vger.kernel.org>; Tue, 14 Mar 2017 17:52:26 +0000 (UTC)
Date: Wed, 15 Mar 2017 02:52:23 +0900 (JST)
Message-Id: <20170315.025223.59681218388873786.yamato@redhat.com>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] fincore command
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20170313145041.senno5cucpkp6s57@ws.net.home>
References: <20170307023352.7340-1-yamato@redhat.com>
        <20170313145041.senno5cucpkp6s57@ws.net.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi, thank you for comments.

On Mon, 13 Mar 2017 15:50:41 +0100, Karel Zak <kzak@redhat.com> wrote:
> Not sure if I like the format ;-)
> 
>  $ fincore /etc/fstab /bin/emacs
>  1          1544       /etc/fstab
>  4156       17163144   /bin/emacs
> 
> Why we need file size there? Would be better to use filename as the
> first column?

* Why we need file size there?

I don't insist including the file size column.

The original reason was that I assumed that a user may want to know
how much part of the file printed by fincore is in core. The file-size
column is for the hint.

How about adding an option to control show the column (--file-size|-s)?
Or should I delete the column fron the output completely?

* Would be better to use filename as the first column?

I follow the format that du and ls commands use:

    $ du /etc/passwd
    4	/etc/passwd

    $ ls -i /tmp | head
    67003 emacs1000
    47611 systemd-private-dd34e7d700c6441db79e4caa7b3c3205-colord.service-N7dhub
    24891 systemd-private-dd34e7d700c6441db79e4caa7b3c3205-rtkit-daemon.service-WbOmt1

du and ls are popular enough. So potential users of fincore
command may be familiar with the formats.

There are two benefits this(du style) format.

+ awk/read/cut commands friendly

White spaces can be included in a file name.
As the result, a user cannot assume the column
for the page counts easily if filename is at the
first column.

e.g. 

    (the format in my patch)
    $ touch 'a b'
    $ ./util-linux/fincore 'a b'
    0          0          a b
    $ ./util-linux/fincore 'a b' | awk '{print $1}'
    0
    $ ./util-linux/fincore 'a b' | { read A REST; echo $A; }
    0
    $ ./util-linux/fincore 'a b' | cut -d ' ' -f1 
    0

+ beauty of output

If filename is at the first column, I wonder
how can I print lines in column aligned way:

    0         -1         /foo/bar/baz/very---long---file---name
    0          0          shortname

By finding the longest file name from arguments passed to fincore
command, the column length can be calumniated, and fincore may be
able to print following lines:

    /foo/bar/baz/very---long---file---name	0         -1         
    shortname					0          0

However, I wonder what I should do if multibyte characters are
used in the file name.

Of course, the column alignment is less important than providing the
way to know much file contents are incore to users.

> it would be also nice have a way how to print only the number if only one
> file specified. Then you can use it in scripts without awk (or so),
> just:
> 
>   FILEPAGES=$(fincore /bin/emacs)
> 

In the station(interactive use) that a user of fincore knows the
number of file names passed to the command, printing only the number
is bettern. However, there can be a situation(scripting) that a user
cannot know the number of file names.

{ 
  FILES=...
  FILES="$FILES $tmp"
  ...
  
  fincore $FILES
} | do_something

In such case the columns are fixed(the page numbers and file name)
will be better for people writing `do_something'. For the such
use case, I would like to add an option --print-filename-always.
The default behavior (behavior without the option) should be
implemented as what you wrote (just printing the number).
Is it o.k.?

After getting feedback from you, I will submit v2 patches.

Masatake YAMATO
