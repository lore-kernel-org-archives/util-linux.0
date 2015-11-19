Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45943 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892AbbKSLFP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 19 Nov 2015 06:05:15 -0500
Date: Thu, 19 Nov 2015 12:05:11 +0100
From: Karel Zak <kzak@redhat.com>
To: "U.Mutlu" <for-gmane@mutluit.com>
Cc: util-linux@vger.kernel.org
Subject: Re: RFC: usermount - a secure mount for unpriviledged users
Message-ID: <20151119110511.GB4955@ws.net.home>
References: <n2ibqp$ui6$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <n2ibqp$ui6$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 18, 2015 at 06:17:12PM +0100, U.Mutlu wrote:
> Currently no responsible admin can grant permission to the mount pgm
> to his users, because of the dangers inherent with bind-mounting etc.

man mount, "The non-superuser mounts." section.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
