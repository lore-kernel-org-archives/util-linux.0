Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20646 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546Ab1H3Jl4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 30 Aug 2011 05:41:56 -0400
Date: Tue, 30 Aug 2011 11:00:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Francesco Cosoleto <cosoleto@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fdisk: print a message with size and type of created
	partition
Message-ID: <20110830090017.GA16159@nb.net.home>
References: <1313533146-2806-1-git-send-email-cosoleto@gmail.com> <1313580072-27979-1-git-send-email-cosoleto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313580072-27979-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 17, 2011 at 01:21:12PM +0200, Francesco Cosoleto wrote:
>  fdisk/Makefile.am     |    2 +-
>  fdisk/fdisk.c         |   13 +++++++++++++
>  fdisk/fdisk.h         |    1 +
>  fdisk/fdisksgilabel.c |    9 ++++++++-
>  fdisk/fdisksunlabel.c |    4 ++++
>  5 files changed, 27 insertions(+), 2 deletions(-)

 Applied (all 5 patches), thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
