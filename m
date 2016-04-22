Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38586 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752443AbcDVKB1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 22 Apr 2016 06:01:27 -0400
Date: Fri, 22 Apr 2016 12:01:25 +0200
From: Karel Zak <kzak@redhat.com>
To: Earnestly <zibeon@googlemail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Remove AC_CONFIG_AUX_DIR
Message-ID: <20160422100125.idwxa5dgbdzc56kt@ws.net.home>
References: <20160420211755.GD17469@teapot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160420211755.GD17469@teapot>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 20, 2016 at 10:17:55PM +0100, Earnestly wrote:
> Likewise in cloog[0] and check[1], using autoreconf -i (or autogen.sh) results
> in ./configure failing with:
> 
>     configure.ac:137: error: required file 'config/ltmain.sh' not found

I'm not able to reproduce this problem.

> This commit simply removes this AUX_DIR which lets the ./configure phase
> complete successfully.

And side-effects? Why we have config/ directory at all?

Frankly, I don't like the patch. AC_CONFIG_AUX_DIR([config]) means
that all the generated files/symlinks are stored in config/ rather
than in project root directory. I'd like to keep the top level
directory usable.


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
