Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47136 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756509AbaFZLHK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jun 2014 07:07:10 -0400
Date: Thu, 26 Jun 2014 13:07:02 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: fallocate: --punch option parsing error diagnostics irritating
Message-ID: <20140626110702.GA750@x2.net.home>
References: <53AB2E36.5060405@bernhard-voelker.de>
 <20140626101009.GD30418@x2.net.home>
 <53ABFB5A.9020005@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <53ABFB5A.9020005@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 26, 2014 at 11:52:10AM +0100, Pádraig Brady wrote:
> --help could he clarified:
> 
> diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
> index d950f9c..6192f0a 100644

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
