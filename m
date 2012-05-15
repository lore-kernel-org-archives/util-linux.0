Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37552 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932120Ab2EOJFF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 May 2012 05:05:05 -0400
Date: Tue, 15 May 2012 11:05:01 +0200
From: Karel Zak <kzak@redhat.com>
To: "Vladimir =?utf-8?Q?'=CF=86-coder=2Fphcoder'?= Serbinenko"
	<phcoder@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] allow to create a minix3fs with a blocksize != 1K
Message-ID: <20120515090501.GA8268@x2.net.home>
References: <4FAAE6EA.3080308@gmail.com>
 <4FAAE7FB.2060808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4FAAE7FB.2060808@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 09, 2012 at 11:56:11PM +0200, Vladimir 'φ-coder/phcoder' Serbinenko wrote:
> Have used it to test minixfs support with various block sizes.

 Looks good, but

> +int MINIX_BLOCK_SIZE = 0;

 is dirty, what about

   int block_size = 0;


 Vladimir, use also 'Signed-off-by:' in commit message for your patches, please.

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
