Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752837AbdASUCG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 19 Jan 2017 15:02:06 -0500
Date: Thu, 19 Jan 2017 21:01:51 +0100
From: Karel Zak <kzak@redhat.com>
To: Martin Mares <mj@ucw.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: Partition alignment in fdisk
Message-ID: <20170119200151.xkehhwppqwjmw4gt@ws.net.home>
References: <mj+md-20170119.164524.14268.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <mj+md-20170119.164524.14268.nikam@ucw.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Thu, Jan 19, 2017 at 05:53:42PM +0100, Martin Mares wrote:
> Is there any way to override fdisk's default partition
> alignment to 1 MB?

Create the first partition by default way and then use expert menu
('x'), command 'b' to move begin of the first partition.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
