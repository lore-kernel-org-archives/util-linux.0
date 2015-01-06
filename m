Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33743 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755006AbbAFK6H (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 Jan 2015 05:58:07 -0500
Date: Tue, 6 Jan 2015 11:58:02 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 03/10] ipcrm: gettextize the command synopsis of the
 usage text
Message-ID: <20150106105802.GE18528@x2.net.home>
References: <1419440170-10850-1-git-send-email-bensberg@justemail.net>
 <1419440170-10850-3-git-send-email-bensberg@justemail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419440170-10850-3-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 24, 2014 at 05:56:03PM +0100, Benno Schulenberg wrote:
> -	fprintf(out, " %s [options]\n", program_invocation_short_name);
> -	fprintf(out, " %s shm|msg|sem <id>...\n", program_invocation_short_name);
> +	fprintf(out, _(" %s [options]\n"
> +		       " %s shm|msg|sem <id>...\n"), program_invocation_short_name);

 Forgot "%1$s" ;-) Fixed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
