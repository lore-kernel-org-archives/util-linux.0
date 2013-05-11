Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f182.google.com ([209.85.220.182]:59498 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab3EKXjO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 11 May 2013 19:39:14 -0400
Received: by mail-vc0-f182.google.com with SMTP id ia10so4590006vcb.41
        for <util-linux@vger.kernel.org>; Sat, 11 May 2013 16:39:13 -0700 (PDT)
Received: from localhost (ool-4a582486.dyn.optonline.net. [74.88.36.134])
        by mx.google.com with ESMTPSA id a17sm7647982vdj.2.2013.05.11.16.39.11
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 11 May 2013 16:39:11 -0700 (PDT)
Date: Sat, 11 May 2013 19:39:10 -0400
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Subject: loopdev regression with v2.23
Message-ID: <20130511233910.GO494@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I have a bug report that points out that v2.23 has disallowed losetup of
a block device with an offset:

https://bugs.archlinux.org/task/35193

As I also note in the bug report, I've bisected this to commit 293714c0d15.

I'm not clear on what the proper fix is here -- "expected_size" is set
to 0 since the fstat call is performed on a special file which has a 0
size. Is the right thing to do simply return 0 if the size of the
"backing file" is 0?

There's also the problem of the error message -- the fabricated ERANGE
return fails to also set errno=ERANGE before returning.

Cheers,
Dave
