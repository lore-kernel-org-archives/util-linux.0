Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:61835 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753795AbaEKWiP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 11 May 2014 18:38:15 -0400
Received: from brln-4d0cc907.pool.mediaways.net ([77.12.201.7]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MDFB2-1WbrYX3YNw-00Gc3A
 for <util-linux@vger.kernel.org>; Mon, 12 May 2014 00:38:14 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: question about test suite regarding stderr/stdout
Date: Mon, 12 May 2014 00:38:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201405120038.12221.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

if you do this grep in util-linux
  git grep '2>&1 >> $TS_OUTPUT' tests/ts

then you find 45 lines like this
$TS_CMD_MKCRAMFS -n $LABEL $IMAGE_SRC $IMAGE_PATH 2>&1 >> $TS_OUTPUT

which means that these warnings go to make's output but not to 
$TS_OUTPUT.

I'm not sure whether this is really always wanted. For me it often looks 
like a typo which should be ">> $TS_OUTPUT 2>&1" instead. Of course 
could also be that it's really wanted as is to ignore stderr of too 
verbose commands.

Could somebody please check this too?
I'v had some cases where I would have liked to see that stderr in test 
diff instead of build log. Moreover because of parallel tests it can be 
difficult to find out which warning belongs to which particular test.

cu,
Rudi
