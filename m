Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38230 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754974AbaEEIei (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 May 2014 04:34:38 -0400
Message-Id: <1399278878.12657.113701373.0499DDA9@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1399218596-21321-2-git-send-email-kerolasa@iki.fi>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
 <1399218596-21321-2-git-send-email-kerolasa@iki.fi>
Subject: Re: [PATCH 01/15] cytune: rename threshold and timeout variables
Date: Mon, 05 May 2014 10:34:38 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, May 4, 2014, at 17:49, Sami Kerola wrote:
> +			threshold_def_val = strtou32_or_err(optarg,
> +						_("Invalid threshold default value"));
> +			if (threshold_def_val < 0 || 12 < threshold_def_val) {
> +				warnx(_("Invalid threshold default value: %d"),

Again, swap "threshold" and "default".

> +						_("Invalid set timeout value"));
> +			if (timeout_val < 1 || 255 < timeout_val) {
> +				warnx(_("Invalid set timeout value: %d"),
> +				      timeout_val);

s/set//

> +						_("Invalid default timeout value"));
> +			if (timeout_def_val < 0 || 255 < timeout_def_val) {
>  				warnx(_("Invalid default time value: %d"),

s/time/timeout/

Benno

-- 
http://www.fastmail.fm - The professional email service

