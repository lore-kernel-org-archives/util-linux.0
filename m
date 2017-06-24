Return-Path: luto@kernel.org
MIME-Version: 1.0
In-Reply-To: <9ace66eed2d16303fd2a8d157875c4acca043f14.1498312679.git.ps@pks.im>
References: <cover.1498312509.git.ps@pks.im> <9ace66eed2d16303fd2a8d157875c4acca043f14.1498312679.git.ps@pks.im>
From: Andy Lutomirski <luto@kernel.org>
Date: Sat, 24 Jun 2017 13:44:07 -0700
Message-ID: <CALCETrXsinSXsg-PD6QV8K3czErALQhGX8bQQhryNHFo8T5zVw@mail.gmail.com>
Subject: Re: [PATCH 1/5] setpriv: introduce indirection for `capng_type` enum
To: Patrick Steinhardt <ps@pks.im>
Cc: util-linux@vger.kernel.org, Andrew Lutomirski <luto@kernel.org>,
	Karel Zak <kzak@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <util-linux.vger.kernel.org>

On Sat, Jun 24, 2017 at 7:04 AM, Patrick Steinhardt <ps@pks.im> wrote:
> The capng_type is used to distinguish the different types of capability
> sets, that is the effective, inheratibale, permitted capabilities as
> well as the capability bounding set. In Linux 4.3, a new set of
> capabilities was introduced with ambient capabilities. Unfortunately,
> libcap-ng does not provide any support for these kind of capabilities
> and as such, we will have to roll our own support.
>
> As a first step, we introduce an indirection for the `capng_type` enum,
> allowing us to add the ambient capability type later on. Right now, no
> functional change is expected from this change and in fact, each of the
> newly introduce enums should have the same value as respective enum of
> libcap-ng.

Looks good to me.
