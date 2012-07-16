Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:31624 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753706Ab2GPSpF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Jul 2012 14:45:05 -0400
Date: Mon, 16 Jul 2012 18:27:15 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] static analysis, and help to translator
Message-ID: <20120716162715.GJ9087@x2.net.home>
References: <CAG27Bk0qDyt0q7vVtCeOgdWDN_r7mW+gUVnyMLUjY1CnbT+LZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0qDyt0q7vVtCeOgdWDN_r7mW+gUVnyMLUjY1CnbT+LZw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 15, 2012 at 10:40:30PM +0200, Sami Kerola wrote:
>       libblkid: remove duplicate entries in symbols
>       lib/pager: minor compiler warning fixes
>       lib/loopdev: minor bug fix: add missing semicolon
>       swapon: remove unused variables
>       utmpdump: remove unused variable
>       look: remove extra semicolon
>       fdisk: make if clause easier to read
>       su: align with howto-usage-function
>       utmpdump: use help and version output macros
>       translation: unify stat error messages
>       translation: unify file open error messages

 Applied,

>       build-sys: reduce warning noise when compiling with clang
>       findmnt: add missing initializer

 not applied. Thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
