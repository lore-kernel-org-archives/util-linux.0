Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.17.24]:62909 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801AbaFYUQ5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jun 2014 16:16:57 -0400
Message-ID: <53AB2E36.5060405@bernhard-voelker.de>
Date: Wed, 25 Jun 2014 22:16:54 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: fallocate: --punch option parsing error diagnostics irritating
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

<naive_user>

Let's create a file:

  $ dd if=/dev/zero of=/tmp/x bs=1000000 count=1 status=none

  $ ls -ldog /tmp/x
  -rw-r--r-- 1 1000000 Jun  6 08:32 /tmp/x

Now, somehow I want to punch holes into it, use -p:

  $ ./fallocate -p /tmp/x
  fallocate: no length argument specified

Well, okay then try with -l:

  $ ./fallocate -p -l 10000 /tmp/x
  fallocate: only -n mode can be used with --zero-range

Huh? I didn't specify neither -n nor -z.

Well, let's try -n then:

  $ ./fallocate -p -n /tmp/x
  fallocate: no length argument specified

Reading 'man fallocate' regarding --punch doesn't help either:

  -p, --punch-hole
        Punch holes in the file, the range should not
        exceed the length of the file.

What does "punching" mean? Please explain without using the
word "punch".
And how would one specify a "range"? There's no option with
such a "range" argument.
Finally, please add some examples to the man page.

Thanks!

</naive_user>
