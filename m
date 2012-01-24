Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25421 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755734Ab2AXLCX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jan 2012 06:02:23 -0500
Date: Tue, 24 Jan 2012 12:02:18 +0100
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Cc: Masatake YAMATO <yamato@redhat.com>, Roger Leigh <rleigh@codelibre.net>
Subject: Re: /etc/fstab.d yes or not (resolved)
Message-ID: <20120124110218.GA28644@x2.net.home>
References: <20120120140444.GC13157@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120120140444.GC13157@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 I have reverted the fstab.d support. The libmount will NOT read
 /etc/fstab.d by default.

 If you really need an additional configuration outside /etc/fstab
 then you have to explicitly add the option --fstab <path> to mount(8)
 command line. This option may be specified more than once and the
 <path> may be a directory. This solution should be enough for
 initramfs scripts.

 Thanks for feedback.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
