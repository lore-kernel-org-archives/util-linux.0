Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ve0-f173.google.com ([209.85.128.173]:56327 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab3CQJXV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Mar 2013 05:23:21 -0400
Received: by mail-ve0-f173.google.com with SMTP id oz10so3666317veb.18
        for <util-linux@vger.kernel.org>; Sun, 17 Mar 2013 02:23:20 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
References: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
Date: Sun, 17 Mar 2013 09:23:20 +0000
Message-ID: <CAG27Bk3bipq_J4LMuNu1MFwQ_QBDeAAA03vxQOEWjGenaGGRMg@mail.gmail.com>
Subject: Re: [PATCH 0/7] pull: whereis changes
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Mar 16, 2013 at 11:40 PM, Sami Kerola <kerolasa@iki.fi> wrote:
> Here are the results of the whereis(1) work which I mentioned earlier the
> week in irc.  All of the patches are related to that command, and as you
> can see from the diff stats a lot has changed.
>
> The first patch is quite big.  Unfortunately I ran out of imagination how
> to make it smaller, as the patch is the core change enabling rest of the
> work.  Most what the 0001 has got going is with search directory list
> building using new data structure.
>
> In between patches are quite straight forward till second last which will
> canonicalize output file names.  I think that is what users are
> interested, but I a may be wrong as well.  Comments, anyone?
>
> The last patch is a bug fix to RedHat item.  See commit message for
> further details.
>
> One funky side note.  After the changes the whereis seems to run about
> 20% quicker.  That was unintentional enhancement.

Hi,

Is this regression, or a command behavior change resulting to correct
output when not patched? I think earlier whereis misbehaved. Reason
being is that shell 'which' or path completion does not recognize
broken symlink.

$ cd ~/bin
$ ln -s bar foo
$ whereis foo
foo: /home/kerolasa/bin/foo
$ cd ~/src/util-linux
$ ./whereis foo
# no results
$ git diff
diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index 0e333e1..30a6819 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -179,7 +179,8 @@ static int is_same_file(char *file, struct is_here
*filelist)
        struct is_here *prev = NULL;

        if (stat(file, &statbuf))
-               return 1;
+               if (lstat(file, &statbuf))
+                       return 1;
        while (filelist) {
                if (filelist->st_ino == statbuf.st_ino &&
                    filelist->st_dev == statbuf.st_dev)
$ make
# <...>
./whereis foo
foo: /home/kerolasa/bin/foo

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
