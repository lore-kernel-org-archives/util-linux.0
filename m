Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750907AbeCFLT7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 6 Mar 2018 06:19:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5EE824023150
        for <util-linux@vger.kernel.org>; Tue,  6 Mar 2018 11:19:59 +0000 (UTC)
Date: Tue, 6 Mar 2018 12:19:56 +0100
From: Karel Zak <kzak@redhat.com>
To: Tony Asleson <tasleson@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/1] libblkid: ignore private Stratis devices
Message-ID: <20180306111956.o3pyv3vjld6ye462@ws.net.home>
References: <20180305185611.16667-1-tasleson@redhat.com>
 <20180305185611.16667-2-tasleson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180305185611.16667-2-tasleson@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 05, 2018 at 12:56:11PM -0600, Tony Asleson wrote:
> +		} else if (strncmp(id, "stratis-", 8) == 0) {
> +			/* Private Stratis devices will be those that start with "stratis-"
> +			 * and that do not match the expected pattern for a thinly
> +			 * provisioned device.
> +			 */
> +			if (!regcomp(&re,
> +						"^stratis-1-[0-9a-f]{32}-thin-fs-[0-9a-f]{32}$",
> +						REG_EXTENDED)) {
> +				if (REG_NOMATCH == regexec(&re, id, 0, NULL, 0))
> +					rc = 1;
> +
> +				regfree(&re);
> +			}

regcomp() ... would be possible to identify the device by any other
way? It would be nice to keep the code simple and stupid.

BTW, why you do not use any special prefix for the private device?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
