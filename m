Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33634 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932384AbaJHJo5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 8 Oct 2014 05:44:57 -0400
Date: Wed, 8 Oct 2014 11:44:53 +0200
From: Karel Zak <kzak@redhat.com>
To: Francis Moreau <francis.moro@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: losetup: failed to setup loop device > 1
Message-ID: <20141008094453.GF8057@x2.net.home>
References: <5432C4C8.30101@gmail.com>
 <20141006174041.GA8057@x2.net.home>
 <54330294.1090908@gmail.com>
 <20141007091711.GB8057@x2.net.home>
 <5433B316.30106@gmail.com>
 <5434FC75.7060209@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5434FC75.7060209@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 08, 2014 at 10:57:25AM +0200, Francis Moreau wrote:
> In HEAD of the git tree, in file losetup.c, the return value of
> loopcxt_add_device() is not checked in main().
> 
> Is this expected ?

Good question :-)

The loop-control is optional (from the code point of view). If the system 
does not have control file (old kernels) and on command line specified loop
device does not exist then it will end with open() error later
(in loopcxt_setup_device()).

Yes, we can improve the main() and add an error message there, but no
sure how usable it will be for end-users (open() errors are pretty
obvious compare to all possible situations in loopcxt_add_device()).

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
