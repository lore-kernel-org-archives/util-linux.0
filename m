Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56153 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752761Ab2IDKu6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 4 Sep 2012 06:50:58 -0400
Date: Tue, 4 Sep 2012 12:50:54 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] fdisk: document FDISK_DEBUG
Message-ID: <20120904105054.GA28558@x2.net.home>
References: <1345625829.2623.0.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345625829.2623.0.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 22, 2012 at 10:57:09AM +0200, Davidlohr Bueso wrote:
>  fdisks/fdisk.8 |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

 Applied, thanks. It would be nice to have this info also in findmnt,
 mount, umount, wipefs, partx, ... man pages. (LIBBLKID_DEBUG= and
 LIBMOUNT_DEBUG=)

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
