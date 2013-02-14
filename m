Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44587 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760209Ab3BNNGj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Feb 2013 08:06:39 -0500
Date: Thu, 14 Feb 2013 14:06:35 +0100
From: Karel Zak <kzak@redhat.com>
To: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] libblkid: Don't keep reading same sector of ISO
Message-ID: <20130214130635.GA19379@x2.net.home>
References: <1360617732-4770-1-git-send-email-zeeshanak@gnome.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360617732-4770-1-git-send-email-zeeshanak@gnome.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 11, 2013 at 11:22:11PM +0200, Zeeshan Ali (Khattak) wrote:
>  libblkid/src/superblocks/iso9660.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
