Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:51670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752485AbeFANZy (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 1 Jun 2018 09:25:54 -0400
From: =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To: Karel Zak <kzak@redhat.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: hardlink util -- files de-duplication
In-Reply-To: <20180601113807.ghf6dtcd5xa6qptu@ws.net.home>
References: <20180601113807.ghf6dtcd5xa6qptu@ws.net.home>
Date: Fri, 01 Jun 2018 15:25:48 +0200
Message-ID: <87lgby1vvn.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@redhat.com> writes:
> Comments & objections?

Not objecting but I feel like I should mention there are multiple
well-established alternatives:

https://github.com/tobiasschulz/fdupes
http://freedup.org/
https://rdfind.pauldreik.se/
https://github.com/markfasheh/duperemove

-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Linux GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
