# ABB 해커톤

AI 빅데이터 개발톤

## 프로젝트 소개

인파 정보 및 공공 API를 러닝하여 사람들이 많이 없는 유명한 핫 플레이스를 추천하는 어플 구축

## 프로젝트 기간

23.11.09 ~ 23.11.10

## 팀 소개

<table>
    <tbody>
        <td align="center";><a href="https://github.com/Suhwan0818"><img src="https://avatars.githubusercontent.com/u/70519298?v=4" width="100px;" alt=""/><br /><sub><b>류준형 (팀장 & 설계)</b></sub></a><br /></td>
        <td align="center";><a href="https://github.com/Suhwan0818"><img src="https://avatars.githubusercontent.com/u/48269420?v=4" width="100px;" alt=""/><br /><sub><b>김수환 (프론트엔드)</b></sub></a><br /></td>
        <td align="center";><a href="https://github.com/Suhwan0818"><img src="https://avatars.githubusercontent.com/u/70519352?v=4" width="100px;" alt=""/><br /><sub><b>김건호 (백엔드)</b></sub></a><br /></td>
        <td align="center";><a href="https://github.com/LouisKimDev/abb_hackerthon_django"><img src="https://avatars.githubusercontent.com/u/112796891?v=4" width="100px;" alt=""/><br /><sub><b>김도윤 (백엔드)</b></sub></a><br /></td>
    </tbody>
</table>

## 개발 환경

- 언어: Dart, Java, Python
- 라이브러리 및 프레임워크: Flutter, Spring Boot, pytorch

## 기능 별 배운점

### 완성본

![complete_file](/assets/complete_file.gif)

### API 처리

- flutter에서의 http처리는 웹과 별 차이 없지만 인터넷 없이도 접속 가능한 상황을 예외처리할 필요가 있음
- StreamBuilder를 사용하여 스트림의 현재 스냅샷에 따라 UI 업데이트 가능

### Widget 로직

- 기존 웹과 완전히 다른 Widget 개념 Material UI가 대표적인 아이콘을 제공해 추가적인 라이브러리를 크게 설치하지 않아도 다양한 활용가능
- Android를 설계했음에도 IOS역시 지원하는 형태에 대한 궁금점이 생겨 공부할 필요성이 있음

### 전날 대비 인원

- 오늘 시간 호출 인원 / 어제자 같은 시간 호출 인원을 퍼센트로 도출 코드는 다음과 같다

```dart
SharedPreferences prefs = await SharedPreferences.getInstance();
int yesterdayPeople = prefs.getInt('current_people') ?? 0;
int currentPeople = await fetchCurrentPeople('37.5665', '126.9780');
print('오늘의 인원: $currentPeople, 어제의 인원: $yesterdayPeople, 차이: ${currentPeople - yesterdayPeople}');
await prefs.setInt('current_people', currentPeople);
```
