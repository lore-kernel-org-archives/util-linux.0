Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46856 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754847AbaIVUSb (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Sep 2014 16:18:31 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by gateway2.nyi.internal (Postfix) with ESMTP id DDCB320926
	for <util-linux@vger.kernel.org>; Mon, 22 Sep 2014 16:18:30 -0400 (EDT)
Message-Id: <1411417110.2384317.170486897.6828935E@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
References: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
Subject: Re: [PATCH 01/10] textual: use angular brackets around each individual
 argument
Date: Mon, 22 Sep 2014 22:18:30 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Mon, Sep 22, 2014, at 22:15, Benno Schulenberg wrote:
> -	fputs(_(" -u, --user <name|id>   interpret argument as username or user ID\n"), out);
> +	fputs(_(" -u, --user <name>|<id> interpret argument as username or user ID\n"), out);

Sami?  How come that this change, that you seemed to have applied,
wasn't propagated to the github branch that Karel pulled?

Benno

-- 
http://www.fastmail.fm - Email service worth paying for. Try it for free

