Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1436 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309Ab3ENNmX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 May 2013 09:42:23 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4EDgNvF024035
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 14 May 2013 09:42:23 -0400
Date: Tue, 14 May 2013 15:42:21 +0200
From: Karel Zak <kzak@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: ReFS
Message-ID: <20130514134221.GA7509@x2.net.home>
References: <20130514110316.GA17246@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130514110316.GA17246@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 14, 2013 at 12:03:16PM +0100, Richard W.M. Jones wrote:
> ReFS is Microsoft's new filesystem used in Windows 2012 Server and
> above.  There's no support for this in Linux (although I'm hoping to
> change that) but it'd be nice if blkid could at least recognize it.
> 
> So I thought you might be interested in the filesystem signature for
> ReFS, which appears to be in the first 8 bytes:

 It seems like NTFS where is 

        struct ntfs_super_block {
            uint8_t		jump[3];
            uint8_t		oem_id[8];	    /* magic string */

 and the magic string is "NTFS    ".

> 00000000  00 00 00 52 65 46 53 00  00 00 00 00 00 00 00 00  |...ReFS.........|
> 00000010  46 53 52 53 00 02 c8 6b  00 00 4e 01 00 00 00 00  |FSRS...k..N.....|
> 00000020  00 02 00 00 80 00 00 00  01 01 00 00 00 00 00 00  |................|
> 00000030  00 00 00 00 00 00 00 00  95 0a d9 2c 1b d9 2c 02  |...........,..,.|
> 00000040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> 
> There is nothing else that looks even vaguely like a superblock within
> the first few megabytes, so I'd go with those first 8 bytes for now.

 The question is where is UUID and LABEL :-) 

 BTW, I found:
    http://www.williballenthin.com/forensics/refs/

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
