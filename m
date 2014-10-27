Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34807 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752225AbaJ0VYg (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Oct 2014 17:24:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id EC03B210F9
	for <util-linux@vger.kernel.org>; Mon, 27 Oct 2014 17:24:35 -0400 (EDT)
Message-Id: <1414445075.1871991.183947489.0B2FD4D2@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1414444693-16407-3-git-send-email-bensberg@justemail.net>
References: <1414444693-16407-1-git-send-email-bensberg@justemail.net>
 <1414444693-16407-3-git-send-email-bensberg@justemail.net>
Subject: Re: [PATCH 3/4] textual: slice up the usage text of swapon for ease of
 translation
Date: Mon, 27 Oct 2014 22:24:35 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Mon, Oct 27, 2014, at 22:18, Benno Schulenberg wrote:
> +	fputs(_(" -v, --verbose            verbose mode\n"), out);
>  
>  	fputs(USAGE_SEPARATOR, out);
>  	fputs(USAGE_HELP, out);

A bit further down in the usage text it says this:

        fputs(_("\nAvailable discard policy types (for --discard):\n"
                " once    : only single-time area discards are issued. (swapon)\n"
                " pages   : discard freed pages before they are reused.\n"
                " * if no policy is selected both discard types are enabled. (default)\n"), out);

Why is this "(swapon)" there?  What does it mean?

Benno

-- 
http://www.fastmail.fm - The professional email service

