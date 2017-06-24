Return-Path: luto@kernel.org
MIME-Version: 1.0
In-Reply-To: <67161af0d3de99c7d70b8cb61bc86300b9e35220.1498312679.git.ps@pks.im>
References: <9ace66eed2d16303fd2a8d157875c4acca043f14.1498312679.git.ps@pks.im>
 <cover.1498312509.git.ps@pks.im> <67161af0d3de99c7d70b8cb61bc86300b9e35220.1498312679.git.ps@pks.im>
From: Andy Lutomirski <luto@kernel.org>
Date: Sat, 24 Jun 2017 13:45:18 -0700
Message-ID: <CALCETrV1UXejijG+V0jVseVzDczZjmBr0XC_5xbRQsSyQRNdZA@mail.gmail.com>
Subject: Re: [PATCH 3/5] setpriv: proxy function to update capabilities
To: Patrick Steinhardt <ps@pks.im>
Cc: util-linux@vger.kernel.org, Andrew Lutomirski <luto@kernel.org>,
	Karel Zak <kzak@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <util-linux.vger.kernel.org>

On Sat, Jun 24, 2017 at 7:04 AM, Patrick Steinhardt <ps@pks.im> wrote:
> libcap-ng provides a function to update capabilities with
> `capng_update`. As libcap-ng has not yet been updated to enable
> modification of ambient capabilities, we cannot use it to update this
> set, though. In order to allow easily extending the logic to also handle
> ambient capability sets, we create a new function `cap_update`. Right
> now, it simply calls out to `capng_update` for all supported capability
> types.
>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
