Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53744 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752894Ab3H2KPa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Aug 2013 06:15:30 -0400
Date: Thu, 29 Aug 2013 12:15:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 15/17] last: use configuration struct
Message-ID: <20130829101519.GE24438@x2.net.home>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
 <1377626779-26030-15-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377626779-26030-15-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 27, 2013 at 07:06:17PM +0100, Sami Kerola wrote:
> +	struct last_control ctl;
> +	int c;
>  	usec_t p;
>  
>  	static const struct option long_opts[] = {
> @@ -761,6 +775,11 @@ int main(int argc, char **argv)
>  	      { NULL, 0, NULL, 0 }
>  	};
>  
> +	memset(&ctl, 0, sizeof(struct last_control));
> +	ctl.showhost = TRUE;
> +	ctl.name_len = LAST_LOGIN_LEN;
> +	ctl.domain_len = LAST_DOMAIN_LEN;
> +

  struct last_control ctl = {
         .showhost = TRUE,
         .name_len = LAST_LOGIN_LEN,
         .domain_len = LAST_DOMAIN_LEN
  };

 is good enough, memset() is unnecessary.


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
