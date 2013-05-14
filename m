Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35936 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754306Ab3ENLDU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 May 2013 07:03:20 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4EB3KE5010040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 14 May 2013 07:03:20 -0400
Date: Tue, 14 May 2013 12:03:16 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: ReFS
Message-ID: <20130514110316.GA17246@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

ReFS is Microsoft's new filesystem used in Windows 2012 Server and
above.  There's no support for this in Linux (although I'm hoping to
change that) but it'd be nice if blkid could at least recognize it.

So I thought you might be interested in the filesystem signature for
ReFS, which appears to be in the first 8 bytes:

00000000  00 00 00 52 65 46 53 00  00 00 00 00 00 00 00 00  |...ReFS.........|
00000010  46 53 52 53 00 02 c8 6b  00 00 4e 01 00 00 00 00  |FSRS...k..N.....|
00000020  00 02 00 00 80 00 00 00  01 01 00 00 00 00 00 00  |................|
00000030  00 00 00 00 00 00 00 00  95 0a d9 2c 1b d9 2c 02  |...........,..,.|
00000040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|

There is nothing else that looks even vaguely like a superblock within
the first few megabytes, so I'd go with those first 8 bytes for now.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming blog: http://rwmj.wordpress.com
Fedora now supports 80 OCaml packages (the OPEN alternative to F#)
