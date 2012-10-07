Return-Path: firebird347@gmail.com
MIME-Version: 1.0
Sender: firebird347@gmail.com
In-Reply-To: <20121003102401.GA2149@x2.net.home>
References: <CA+K3q6r_QfCWmCBMEiytKCQG8j-4P92sWxO-ZNz_ALWpr=2knA@mail.gmail.com>
 <20121003102401.GA2149@x2.net.home>
From: Cody Maloney <cmaloney@theoreticalchaos.com>
Date: Sun, 7 Oct 2012 11:08:53 -0600
Message-ID: <CA+K3q6or0gEB_FUYaL4ktVZjWikAWQhb4tQNfQgcFfnLZ54guw@mail.gmail.com>
Subject: Re: Adding support to chsh for non-local shell modification
To: Karel Zak <kzak@redhat.com>, Miloslav Trmac <mitr@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 3, 2012 at 4:24 AM, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Oct 02, 2012 at 07:58:39PM -0700, Cody Maloney wrote:
>> I would like to implement support for non-local shell changing in chsh
>> at the very least, and possibly support for non-local user attributes
>> in general for the other attribute modification tools in login-utils.
>> For my purposes I need LDAP support, but it would probably be better
>> to make it able to use an arbitrary storage backend.  Ideally an API
>> would already exist for this, but while one for setting authentication
>> tokens has evolved (pam_chauthtok) and one for reading user attributes
>> (Name Service Switch NSS), but none for setting them as far as I can
>> tell. As such, I think the best route would be just to make a new API
>> for this.
>
>  Already implemented:
>      https://fedorahosted.org/libuser/
>
>  it also provides utils like lchfn or lchsh. Not sure, but maybe it
>  would be possible to optionally link the default chfn and chsh utils
>  with the library too.

Apologies for the slow response.

Looking at chsh, it definitely looks like it should be relatively easy
to utilize libuser within it and add a configure for disabling the
dependency. If it's okay with both maintainers, both lchsh and chsh
are licensed under the GPL so I'd like to just merge lchsh's code into
chsh (rather than try to write what should be pretty much exactly the
same thing from the API documentation).

If you both approve I'll start working on writing the necessary
patches, first adding support to chsh, then, once those patches are in
a happy state, implementing chfn using the same method.

Cody
