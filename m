Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52313 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755316AbaEEI3d (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 May 2014 04:29:33 -0400
Message-Id: <1399278572.11817.113700257.14395B5D@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 02/15] cytune: remove unnecessary variables
Date: Mon, 05 May 2014 10:29:32 +0200
In-Reply-To: <1399218596-21321-3-git-send-email-kerolasa@iki.fi>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
 <1399218596-21321-3-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, May 4, 2014, at 17:49, Sami Kerola wrote:
> -				warnx(_("Invalid threshold default value: %d"),
> -				      threshold_def_val);
> -				errflg++;
> -			}
> +			if (threshold_def_val < 0 || 12 < threshold_def_val)
> +				errx(EXIT_FAILURE, ("Invalid threshold default value: %d"),

s/threshold default/default threshold/

> -				warnx(_("Invalid set timeout value: %d"),
> -				      timeout_val);
> -				errflg++;
> -			}
> +			if (timeout_val < 1 || 255 < timeout_val)
> +				errx(EXIT_FAILURE, _("Invalid set timeout value: %d"),

s/set timeout/timeout/

>  						_("Invalid default timeout value"));
> -			if (timeout_def_val < 0 || 255 < timeout_def_val) {
> -				warnx(_("Invalid default time value: %d"),
> -				      timeout_def_val);
> -				errflg++;
> -			}
> +			if (timeout_def_val < 0 || 255 < timeout_def_val)
> +				errx(EXIT_FAILURE, _("Invalid default time value: %d"),

s/time/timeout/

Benno

-- 
http://www.fastmail.fm - The professional email service

