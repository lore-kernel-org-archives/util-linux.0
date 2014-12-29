Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33651 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751995AbaL2KJ7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 29 Dec 2014 05:09:59 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id C8846207C2
	for <util-linux@vger.kernel.org>; Mon, 29 Dec 2014 05:09:58 -0500 (EST)
Message-Id: <1419847798.2518197.207547701.6852BB36@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 02/10] ipcs: in usage show resource option as nonoptional
 when used with -i
Date: Mon, 29 Dec 2014 11:09:58 +0100
In-Reply-To: <1419440170-10850-2-git-send-email-bensberg@justemail.net>
References: <1419440170-10850-1-git-send-email-bensberg@justemail.net>
 <1419440170-10850-2-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Wed, Dec 24, 2014, at 17:56, Benno Schulenberg wrote:
>  	fprintf(out, USAGE_HEADER);
> -	fprintf(out, " %s [resource ...] [output-format]\n", program_invocation_short_name);
> -	fprintf(out, " %s [resource] -i <id>\n", program_invocation_short_name);
> +	fprintf(out, _(" %1$s [resource-option...] [output-option]\n"
> +		       " %1$s -m|-q|-s -i <id>\n"), program_invocation_short_name);
>  	fprintf(out, USAGE_OPTIONS);

Ow...  Most of these patching will need rebasing when the docstring
patch has been applied.  Have done that locally and will resubmit.

Benno

-- 
http://www.fastmail.com - Same, same, but different...

