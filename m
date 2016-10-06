Return-Path: aaptel@suse.com
From: =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To: Karel Zak <kzak@redhat.com>, Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libblkid: Avoid strlen if only first char is checked
In-Reply-To: <20161006125912.p2xyff3h44gc36ub@ws.net.home>
References: <20161003200503.GA2287@localhost> <20161006125912.p2xyff3h44gc36ub@ws.net.home>
Date: Thu, 06 Oct 2016 15:22:03 +0200
Message-ID: <mpstwcp3950.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@redhat.com> writes:
> On Mon, Oct 03, 2016 at 10:05:03PM +0200, Tobias Stoeckmann wrote:
>> A strlen() call can lead to out of boundary read access if the
>> superblock in question has no nul-bytes after the string. This
>> could be avoided by using strnlen() but the calls in question
>> merely existed to check if the string length is not 0.
>>=20
>> By changing the calls as proposed with this diff, these files are
>> in sync with other superblock files, which do exactly the same.
>> ---
>>  libblkid/src/superblocks/befs.c  | 2 +-
>>  libblkid/src/superblocks/ext.c   | 2 +-
>>  libblkid/src/superblocks/jfs.c   | 2 +-
>>  libblkid/src/superblocks/nilfs.c | 2 +-
>>  libblkid/src/superblocks/romfs.c | 2 +-
>>  libblkid/src/superblocks/xfs.c   | 2 +-
>>  6 files changed, 6 insertions(+), 6 deletions(-)
>
>  Applied, thanks.
>
>> diff --git a/libblkid/src/superblocks/befs.c b/libblkid/src/superblocks/=
befs.c
>> index 7e9eaf6..36e079f 100644
>> --- a/libblkid/src/superblocks/befs.c
>> +++ b/libblkid/src/superblocks/befs.c
>> @@ -451,7 +451,7 @@ static int probe_befs(blkid_probe pr, const struct b=
lkid_idmag *mag)
>>  	/*
>>  	 * all checks pass, set LABEL, VERSION and UUID
>>  	 */
>> -	if (strlen(bs->name))
>> +	if (*bs->name !=3D '\0')
>
> Good catch, I hate it too. BTW, you can use
>
>     if (*bs->name)
>
> it's enough.

Interesting to note that GCC compiles it both to the same instructions:

https://godbolt.org/g/adKv1I

#include <string.h>
int code1(const char *s) {
  if(strlen(s)) return 1;
  return 0;
}

int code2(const char *s) {
  if(*s) return 1;
  return 0;
}

code1(char const*):
        push    rbp
        mov     rbp, rsp
        mov     QWORD PTR [rbp-8], rdi
        mov     rax, QWORD PTR [rbp-8]
        movzx   eax, BYTE PTR [rax]
        test    al, al
        je      .L2
        mov     eax, 1
        jmp     .L3
.L2:
        mov     eax, 0
.L3:
        pop     rbp
        ret
code2(char const*):
        push    rbp
        mov     rbp, rsp
        mov     QWORD PTR [rbp-8], rdi
        mov     rax, QWORD PTR [rbp-8]
        movzx   eax, BYTE PTR [rax]
        test    al, al
        je      .L5
        mov     eax, 1
        jmp     .L6
.L5:
        mov     eax, 0
.L6:
        pop     rbp
        ret

--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Linux GmbH, Maxfeldstra=C3=9Fe 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N=
=C3=BCrnberg)
