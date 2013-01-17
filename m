Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ie0-f179.google.com ([209.85.223.179]:39255 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756865Ab3AQAw4 convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 16 Jan 2013 19:52:56 -0500
Received: by mail-ie0-f179.google.com with SMTP id k14so3785732iea.38
        for <util-linux@vger.kernel.org>; Wed, 16 Jan 2013 16:52:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1628490120.7233795.1358187377636.JavaMail.root@redhat.com>
References: <1358068345-773-5-git-send-email-cmaloney@theoreticalchaos.com> <1628490120.7233795.1358187377636.JavaMail.root@redhat.com>
From: Cody Maloney <cmaloney@theoreticalchaos.com>
Date: Wed, 16 Jan 2013 16:52:33 -0800
Message-ID: <CA+K3q6qDgdrXxbesZ-373xMYgA=oyjMnaejJWNtBaYj8HfR04w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] chsh: Add libuser support
To: Miloslav Trmac <mitr@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 14, 2013 at 10:16 AM, Miloslav Trmac <mitr@redhat.com> wrote:
> Hello,
> ----- Original Message -----
>> diff --git a/login-utils/libuser.c b/login-utils/libuser.c
>> new file mode 100644
>> index 0000000..9a3e3b1
>> --- /dev/null
>> +++ b/login-utils/libuser.c
>> +static int auth_lu(const char *service_name, struct lu_context *ctx,
>> uid_t uid,
>> +                     const char *username) {
>> +     if(!lu_uses_elevated_privileges(ctx)) {
>> +             /* Drop privileges */
>> +             if (setegid(getgid()) == -1) {
>> +                     errx(EXIT_FAILURE, _("Couldn't drop group privileges"));
>> +                     return FALSE;
>> +             }
>> +             if (seteuid(getuid()) == -1) {
>> +                     errx(EXIT_FAILURE, _("Couldn't drop group privileges"));
>> +                     return FALSE;
>> +             }
>> +             if (initgroups(username, 0)) {
>> +                     errx(EXIT_FAILURE, _("Couldn't drop group privileges"));
>> +                     return FALSE;
>> +             }
>
> I can't see how this can work: after seteuid() the program no longer has root privileges (CAP_SETGID) to change the groups.
>
> (On second thought, if the program is setuid, the setuid execution mechanism doesn't change supplementary groups, so perhaps the call isn't strictly necessary; Still, initializing the groups makes the environment more deterministic.  And as long as initgroups() is called, it should be called in a way that works.)

I'm fine with/would prefer dropping the initgroups entirely (That the
initgroups man page, at least on my system, specifically talks about
reading them from /etc/group, never mentioning nss worries me). If
that's okay with you, otherwise I can move it to the beginning of
dropping privileges.

>
>> +     lu_ent_set_string(ent, attr, val);
>> +     if (!lu_user_modify(ctx, ent, &error)) {
>> +             lu_ent_free(ent);
>> +             lu_end(ctx);
>> +             err(EXIT_FAILURE, _("Shell not changed: %s\n"),
>> lu_strerror(error));
>
> This error message is fine for chsh, but not great for chfn.

Good catch. I'll change it to "Unable to change user attribute".

Thanks,
Cody
