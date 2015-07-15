Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49197 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088AbbGONDl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 15 Jul 2015 09:03:41 -0400
Date: Wed, 15 Jul 2015 15:03:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Scott Moser <smoser@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: add GPT GUIDs for PReP
Message-ID: <20150715130339.GB31997@ws.net.home>
References: <alpine.DEB.2.02.1507141603130.21273@brickies>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1507141603130.21273@brickies>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 14, 2015 at 04:10:17PM -0400, Scott Moser wrote:
> +	/* PowerPC reference platform boot partition */
> +	DEF_GUID("9E1A2D38-C612-4316-AA26-8B49521E5A8B", N_("PowerPC PReP boot")),


 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
