Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50772 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753788Ab2JBJqV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Oct 2012 05:46:21 -0400
Date: Tue, 2 Oct 2012 11:46:10 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] dmesg: fix console-level off-by-one
Message-ID: <20121002094610.GI7730@x2.net.home>
References: <1349135689-13948-1-git-send-email-bjorn@mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1349135689-13948-1-git-send-email-bjorn@mork.no>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 02, 2012 at 01:54:49AM +0200, Bjørn Mork wrote:
>  sys-utils/dmesg.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

 Ah... applied, thanks!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
