Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33194 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753974Ab1HQOoj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Aug 2011 10:44:39 -0400
Date: Wed, 17 Aug 2011 16:44:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Subject: Re: losetup --all --verbose results in usage
Message-ID: <20110817144433.GD699@nb.net.home>
References: <4E4BCC65.2060100@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E4BCC65.2060100@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 17, 2011 at 04:12:53PM +0200, Bernhard Voelker wrote:
> I was surprised that running
> 	mount/losetup --all --verbose
> results in usage().

 Fixed. losetup -a -v works now.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
