Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30262 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037Ab2FEPCQ (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Tue, 5 Jun 2012 11:02:16 -0400
Date: Tue, 5 Jun 2012 17:02:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@gmail.com>
Cc: util-linux-ng@vger.kernel.org
Subject: Re: [pull] login utils and manual fixes
Message-ID: <20120605150212.GO14536@x2.net.home>
References: <CAG27Bk3Cb0hTp=6J8p8wX-=eNKuXa-rEHQwowTD4QZR8PNm2SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk3Cb0hTp=6J8p8wX-=eNKuXa-rEHQwowTD4QZR8PNm2SA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 03, 2012 at 11:09:46PM +0200, Sami Kerola wrote:
> Dave Reisner (1):
>       fileutils: xmkstemp() interface change
> 
> Sami Kerola (10):
>       logindefs: change getlogindefs_num() to return unsigned long
>       build-sys: add su executable to .gitignore
>       login: allow TTYGROUP name begin by number
>       docs: clean up login.1 manual
>       docs: clean up wdctl.8 manual
>       tools: add checkmans.sh
>       docs: fix all man page groff warnings
>       docs: clean up chcpu.8 manual
>       docs: clean up dmesg.1 manual
>       docs: clean up getopt.1 manual

 Merged. Thanks!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
