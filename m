Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbhh.dreamhost.com ([208.97.132.177]:49655 "EHLO
	homiemail-a37.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751334Ab2FJT6l convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 10 Jun 2012 15:58:41 -0400
Subject: Re: [PATCH] allow to create a minix3fs with a blocksize != 1K
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Vladimir =?UTF-8?Q?=27=CF=86-coder/phcoder=27?= Serbinenko
	<phcoder@gmail.com>,
        Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
In-Reply-To: <4FAAE7FB.2060808@gmail.com>
References: <4FAAE6EA.3080308@gmail.com>  <4FAAE7FB.2060808@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 10 Jun 2012 21:58:38 +0200
Message-ID: <1339358318.3369.35.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, 2012-05-09 at 23:56 +0200, Vladimir 'φ-coder/phcoder' Serbinenko
wrote:
> Have used it to test minixfs support with various block sizes.
> 

Hi Vladimir,

A few comments:

+       if (MINIX_BLOCK_SIZE % 512 || MINIX_BLOCK_SIZE < 1024
+           || MINIX_BLOCK_SIZE >= 65536)
+               usage();

This check should be part of the switch statement, perhaps in its own
function.
+       if (*tmp && ...)


+       if (fs_version != 3 && MINIX_BLOCK_SIZE != MINIX12_BLOCK_SIZE)
+               usage();

We should set -1/-2 options to be mutually exclusive with -B.

+#define MAX_MINIX_BLOCK_SIZE 65536
Isn't the max minix block size 4096?

+#define MINIX12_BLOCK_SIZE   1024
This is the minimal block size, including v3. MINIX12_ doesn't describe
it well.


Also, please send the patches in the body of the message - just as with
the lkml.

Thanks,
Davidlohr

