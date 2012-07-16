Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:27083 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843Ab2GPPwC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Jul 2012 11:52:02 -0400
Date: Mon, 16 Jul 2012 17:51:59 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] static analysis, and help to translator
Message-ID: <20120716155159.GA9087@x2.net.home>
References: <CAG27Bk0qDyt0q7vVtCeOgdWDN_r7mW+gUVnyMLUjY1CnbT+LZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0qDyt0q7vVtCeOgdWDN_r7mW+gUVnyMLUjY1CnbT+LZw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 15, 2012 at 10:40:30PM +0200, Sami Kerola wrote:
>       build-sys: reduce warning noise when compiling with clang

 .. I spent hour to improve UL_WARN_ADD and after commit and push I
 found that whole problem could be resolved by an extra -Werror in
 UL_WARN_ADD implementation.

 so the result from CC=clang ./configure is:

checking whether compiler handles -Wextra... yes
checking whether compiler handles -Wno-missing-field-initializers... yes
checking whether compiler handles -Wsign-compare... yes
checking whether compiler handles -Wtype-limits... yes
checking whether compiler handles -Wuninitialized... yes
checking whether compiler handles -Werror=sequence-point... yes
checking whether compiler handles -Wunused-parameter... yes
checking whether compiler handles -fno-common... yes
checking whether compiler handles -Wunused-result... no
checking whether compiler handles -Wmissing-prototypes... yes
checking whether compiler handles -Wunused-variable... yes
checking whether compiler handles -Wmissing-parameter-type... no
checking whether compiler handles -Wunused-but-set-parameter... no
checking whether compiler handles -Wunused-but-set-variable... no
checking whether compiler handles -Wredundant-decls... yes



>       libblkid: remove duplicate entries in symbols
>       lib/pager: minor compiler warning fixes
>       findmnt: add missing initializer

 Why we need this if code is compiled with -Wno-missing-field-initializers?

 It's pretty obvious in C standard how are missing fields are initialized
 in global and static variables.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
