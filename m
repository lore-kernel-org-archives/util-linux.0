Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32919 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307AbcCNMWo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 08:22:44 -0400
Date: Mon, 14 Mar 2016 13:22:41 +0100
From: Karel Zak <kzak@redhat.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.28-rc1
Message-ID: <20160314122241.dd6teohcykobq4c5@ws.net.home>
References: <20160311114701.oqbcsy2aiavj4ejz@ws.net.home>
 <20160313203224.GR4295@var.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160313203224.GR4295@var.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 13, 2016 at 09:32:24PM +0100, Samuel Thibault wrote:
> sigset_t is not a structure on Hurd. Applications are not supposed to
> assume what it is, and the first thing that sulogin.c does on it is
> sigemptyset already anyway

 OK, fixed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
