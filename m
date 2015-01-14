Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49251 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066AbbANUI1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 14 Jan 2015 15:08:27 -0500
Date: Wed, 14 Jan 2015 21:08:07 +0100
From: Karel Zak <kzak@redhat.com>
To: Lucio Crusca <lucio@sulweb.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [BUG] losetup: support for physical devices
Message-ID: <20150114200807.GG28019@x2.net.home>
References: <m96ard$qu8$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m96ard$qu8$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 14, 2015 at 06:59:58PM +0100, Lucio Crusca wrote:
> During a disaster recovery I found that losetup either 
> 
> 1. does not support creating loop devices that target physical devices. In 
> this case I think there exists a compelling reason to support them 
> (http://serverfault.com/questions/659484) and this bug report is a wishlist 
> bug 
> 
> or 
> 
> 2. it does support physical devices, but it is an undocumented feature (at 
> least in the manpage) and the warning it issues is misleading beacuse it 
> makes you think it doesn't support them ("losetup: /dev/sdc2: warning: file 
> smaller than 512 bytes, the loop device maybe be useless or invisible for 
> system tools"). In this case this could be a documentation bug.

commit b048b8af3a5568c90f6e0c2d56f6cb399dedb0d1
Author: Karel Zak <kzak@redhat.com>
Date:   Mon May 13 11:00:47 2013 +0200

    losetup: use warn_size() for regular files only
        
Signed-off-by: Karel Zak <kzak@redhat.com>


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
